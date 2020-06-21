
class PercentEncode {
  static const Map<String,String> char_map = {
    "!" : "%21",
    "#" : "%23",
    "\$" : "%24",
    "&" : "%26",
    "'" : "%27",
    "(" : "%28",
    ")" : "%29",
    "*" : "%2A",
    "+" : "%2B",
    "," : "%2C",
    "/" : "%2F",
    ":" : "%3A",
    ";" : "%3B",
    "=" : "%3D",
    "?" : "%3F",
    "@" : "%40",
    "[" : "%5B",
    "]" : "%5D",
  };

  static String encodeChar(String char){
    return char_map[char] ?? char;
  }

  static String encodeString(String string){
    if(string == null) return '';
    if(string.length == 0) return string;
    String result = '';
    for(final s in string.split('')){
      result += encodeChar(s);
    }
    return result;
  }

}
