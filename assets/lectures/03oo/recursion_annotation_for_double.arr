fun double(lst :: List<Number>) -> List<Number>:
  doc: "produces a new list with every item in lst, doubled"
  cases(List) lst:
    | empty => empty
    | link(fst, rst) => link(2 * fst, double(rst))
  end
end

check:
  double([list: 1, 2, 3]) is [list: 2, 4, 6]
  #                     link(2, [list: 4, 6])
  #                 link(1 * 2, [list: 4, 6])
  #          link(1 * 2, double([list: 2, 3])
  
  double(   [list: 2, 3]) is    [list: 4, 6]
  #                        link(4, [list: 6])
  #                    link(2 * 2, [list: 6])
  #             link(2 * 2, double([list: 3])
  
  double(      [list: 3]) is       [list: 6]
  #                               link(6, empty)
  #                           link(3 * 2, empty)
  #                     link(3 *2, double(empty))
  
  double(empty)           is                empty
end
