import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';

/// {OC} this class is made by barely taking some parts from [ClampingScrollPhysics] 
/// and [BouncingScrollPhysics] by the flutter material library and tweaking 
/// it a bit to achieve new features. every comment that doesn't start with
/// "{OC} " is barely a copy-paste from the material library


bool defaultBounceCallbackCondition(double over, double velocity)
  => customBounceCallbackCondition(1.0, over, velocity);

bool customBounceCallbackCondition(double hard, double over, double velocity) {
  double refVel = 1100;
  if(velocity > hard * refVel * 3  )
    if(over > 15) return true;
  if(velocity > hard * refVel * 2.5)
    if(over > 25) return true;
  if(velocity > hard * refVel * 2  )
    if(over > 30) return true;
  if(velocity > hard * refVel * 1.5)
    if(over > 45) return true;
  if(velocity > hard * refVel      )
    if(over > 50) return true;
  if(velocity > hard * refVel * 0.8)
    if(over > 65) return true;
  if(velocity > hard * refVel / 2  )
    if(over > 70) return true;

  if(velocity >= hard * 50)
    if(over > 100) return true;

  return false;
}


/// {OC} Scroll physics for environments that allow a personalized way to 
/// manage the scroll offset: you can allow the offset to go beyond the 
/// top and/or the bottom of the bounds of the content, and then bounce 
/// the content back to the edge of those bounds.
/// 
/// You can also trigger a callback when the user overscrolls or underscrolls
/// the content over a certain threshold you can set
///
/// This is achieved by mixing and tweaking a bit the behavior of:
///
///  * [BouncingScrollPhysics], which provides the default
///    scroll behavior on iOS.
///  * [ClampingScrollPhysics], which is the analogous physics for Android's
///    clamping behavior.
class SidereusScrollPhysics extends ScrollPhysics {

  /// {OC} Creates scroll physics that can bounce back from the edge and trigger callbacks.
  const SidereusScrollPhysics({ 
    ScrollPhysics parent, 
    this.topBounce, 
    this.callbackCondition,
    this.bottomBounce,
    this.bottomBounceCallback,
    this.topBounceCallback,
    this.alwaysScrollable,
    this.neverScrollable,
  }): super(parent: parent);

  /// {OC} you can customize the behavior of the scrollable object to 
  /// always accept scroll gestures by setting [alwaysScrollable] to true
  final bool alwaysScrollable;
  /// {OC} you can customize the behavior of the scrollable object to 
  /// never accept scroll gestures by setting [neverScrollable] to true
  final bool neverScrollable;

  /// {OC} if true, the top part of the scrollable object will behave like it was on iOS
  /// (as with [BouncingScrollPhysics]), else it will behave like [ClampingScrollPhysics]
  final bool topBounce;

  /// {OC} if true, the bottom part of the scrollable object will behave like it was on iOS
  /// (as with [BouncingScrollPhysics]), else it will behave like [ClampingScrollPhysics]
  final bool bottomBounce;

  /// {OC} if non null, any bouncing part of the scrollable object will be able to trigger a callback
  /// when the user overscrolls (or underscrolls) in a way that makes this function return true
  final bool Function(double over, double velocity) callbackCondition;

  /// {OC} if [topBounce] is true and [callbackThreshold] is non null, the user will trigger 
  /// this callback by underscrolling the object over the top by a given amount of pixels 
  final void Function() topBounceCallback;

  /// {OC} if [topBounce] is true and [callbackThreshold] is non null, the user will trigger 
  /// this callback by overscrolling the object over the bottom by a given amount of pixels
  final void Function() bottomBounceCallback;

  @override
  SidereusScrollPhysics applyTo(ScrollPhysics ancestor) {
    return SidereusScrollPhysics(
      parent: buildParent(ancestor), 
      alwaysScrollable: this.alwaysScrollable,
      neverScrollable: this.neverScrollable,
      topBounce: this.topBounce, 
      bottomBounce: this.bottomBounce, 
      callbackCondition: this.callbackCondition,
      topBounceCallback: this.topBounceCallback,
      bottomBounceCallback: this.bottomBounceCallback,
    );
  }

  /// The multiple applied to overscroll to make it appear that scrolling past
  /// the edge of the scrollable contents is harder than scrolling the list.
  /// This is done by reducing the ratio of the scroll effect output vs the
  /// scroll gesture input.
  ///
  /// This factor starts at 0.52 and progressively becomes harder to overscroll
  /// as more of the area past the edge is dragged in (represented by an increasing
  /// `overscrollFraction` which starts at 0 when there is no overscroll).
  double frictionFactor(double overscrollFraction) => 0.52 * math.pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!position.outOfRange)
      return offset;

    final double overscrollPastStart = math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd = math.max(position.pixels - position.maxScrollExtent, 0.0);
    final double overscrollPast = math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0)
        || (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor((overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(double extentOutside, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit)
        return absDelta * gamma;
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError(
          '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
          'The proposed new position, $value, is exactly equal to the current position of the '
          'given ${position.runtimeType}, ${position.pixels}.\n'
          'The applyBoundaryConditions method should only be called when the value is '
          'going to actually change the pixels, otherwise it is redundant.\n'
          'The physics object in question was:\n'
          '  $this\n'
          'The position object in question was:\n'
          '  $position\n'
        );
      }
      return true;
    }());
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {// underscroll
      if(this.topBounce != true) return value - position.pixels;      
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {// overscroll
      if(this.bottomBounce != true) return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {// hit top edge
      if(this.topBounce != true) 
        return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {// hit bottom edge
      if(this.bottomBounce != true) 
        return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (
      ( velocity.abs() >= tolerance.velocity && 
        position.pixels > position.minScrollExtent && 
        position.pixels < position.maxScrollExtent
      ) ||
      position.outOfRange
    ) {
      bool _underscroll = false;
      bool _overscroll = false;
      double _top = position.pixels - position.minScrollExtent;
      double _bottom = position.pixels - position.maxScrollExtent;
      double _dist = math.min(_top.abs(), _bottom.abs() );

      if (_top < 0) {
        if(this.topBounce == true) _underscroll = true;
      }
      if (_bottom > 0) {
        if(this.bottomBounce == true) _overscroll = true;
      }

      bool Function (double, double) conditionChecker;
      if(this.callbackCondition != null)
        conditionChecker = this.callbackCondition;
      else 
        if(this.bottomBounceCallback != null || this.topBounceCallback != null)
          conditionChecker = defaultBounceCallbackCondition;

      if(conditionChecker != null){
        bool checked = conditionChecker(_dist, velocity.abs()); 
        if(checked){
          if(_overscroll && this.bottomBounceCallback != null && velocity >= 0){
            this.bottomBounceCallback();
          }
          if(_underscroll && this.topBounceCallback != null && velocity <= 0){
            this.topBounceCallback();
          }
        }
      }

      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity * 0.91,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    // return null;
    if (velocity.abs() < tolerance.velocity)
      return null;
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent)
      return null;
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent)
      return null;
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }

  // The ballistic simulation here decelerates more slowly than the one for
  // ClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  // Methodology:
  // 1- Use https://github.com/flutter/scroll_overlay to test with Flutter and
  //    platform scroll views superimposed.
  // 2- Record incoming speed and make rapid flings in the test app.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(), 40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) //=> true;
  {
    if(this.alwaysScrollable == true) return true;
    if(this.neverScrollable ==  true) return false;
    if (parent == null)
      return position.pixels != 0.0 || position.minScrollExtent != position.maxScrollExtent;
    return parent.shouldAcceptUserOffset(position);
  }


}
