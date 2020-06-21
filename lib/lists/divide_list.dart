
extension ListSidSeparate<T> on List<T> {

  List<T> separateWith(T splitter, {
    bool alsoFirst = false,
    bool alsoLast = false,
    bool alsoFirstAndLast = false,
  }) => <T>[
    if((alsoFirst ?? false) || (alsoFirstAndLast ?? false))
      splitter,
    if(this.isNotEmpty) 
      this.first,
    for(int i = 1; i < this.length; ++i)
      ...<T>[
        splitter, 
        this[i]
      ],
    if((alsoLast ?? false) || (alsoFirstAndLast ?? false))
      splitter,
  ];

  List<T> separateWithMultiple(Iterable<T> splitters, {
    bool alsoFirst = false,
    bool alsoLast = false,
    bool alsoFirstAndLast = false,
  }) => <T>[
    if((alsoFirst ?? false) || (alsoFirstAndLast ?? false))
      ...splitters,
    if(this.isNotEmpty) 
      this.first,
    for(int i = 1; i < this.length; ++i)
      ...<T>[
        ...splitters, 
        this[i]
      ],
    if((alsoLast ?? false) || (alsoFirstAndLast ?? false))
      ...splitters,
  ];


}