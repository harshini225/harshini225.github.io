use context essentials2021
# Class worksheet for Brown CS 200, Jan 31 2022 (author: Milda Zizyte)
# the code on this page is starter code; you do not need to modify it

#|
   Reminder: [list: "one", "two", "three"] is equivalent to
link("one",
  link("two",
    link("three", empty)))
|#

data OurList<a>:
  | our-empty
  | our-link(first :: a, rest :: OurList<a>)
end
    
# ***WE ARE ONLY USING THE FOLLOWING DATA AND TWO FUNCTIONS FOR VISUAL REPRESENTATION OF LISTS**
num-list = our-link(111, our-link(15, our-link(17, our-link(112, our-empty))))
# under the hood, same structure as [list: 200, 111, 15, 17, 112]

fun to-list(our-lst :: OurList) -> List:
  doc: "converts an OurList to a List"
  cases(OurList) our-lst:
    | our-empty => empty
    | our-link(fst, rst) => link(fst, to-list(rst))
  end
end

fun to-our-list(lst :: List) -> OurList:
  doc: "converts a List to an OurList"
  cases(List) lst:
    | empty => our-empty
    | link(fst, rst) => our-link(fst, to-our-list(rst))
  end
end

check:
  to-list(our-empty) is empty
  to-list(our-link("a", our-empty)) is [list: "a"]
  to-list(num-list) is [list: 111, 15, 17, 112]
  to-our-list(empty) is our-empty
  to-our-list([list: "a"]) is our-link("a", our-empty)
  to-our-list([list: 111, 15, 17, 112]) is num-list
end

# reminder from last lecture
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
  #                 link(1 * 2, double([list: 2, 3]))
  
  double(   [list: 2, 3]) is    [list: 4, 6]
  #                        link(4, [list: 6])
  #                    link(2 * 2, double([list: 3]))
  
  double(      [list: 3]) is       [list: 6]
  #                                  link(6, empty)
  #                              link(3 * 2, double(empty))
  
  double(empty)           is                empty
end

data Animal:
  | boa(name :: String, length :: Number, eats :: String)
  | dillo(length :: Number, isDead :: Boolean)
end
fred-boa = boa("Fred", 20, "lettuce")
derf-boa = boa("Derf", 10, "LETTUCE")
live-dil = dillo(2, false)
dead-dil = dillo(200, true)
ani-list = [list: live-dil, fred-boa, derf-boa, dead-dil]

fun only-boas(ani-lst :: List<Animal>) -> List<Animal>:
  doc: "returns a list with only the boas from lst"
  cases(List) ani-lst:
    | empty => empty
    | link(first-ani, rest-anis) =>
      if is-boa(first-ani):
        link(first-ani, only-boas(rest-anis))
      else:
        only-boas(rest-anis)
      end
  end
end

# fill in the following check block for only-odds
check:
  only-boas([list: 
      live-dil, 
      fred-boa, 
      derf-boa, 
      dead-dil]) is [list: fred-boa, derf-boa]
  
  only-boas([list:
      fred-boa,
      derf-boa,
      dead-dil]) is [list: fred-boa, derf-boa]
  
  only-boas([list:
      derf-boa,
      dead-dil]) is           [list: derf-boa]
  
  only-boas([list:
      dead-dil]) is            empty
  
  only-boas(empty) is          empty
end
   

fun remove-first-found(lst :: List, val) -> List:
  doc: "returns a list with first instance of val removed from lst"
  cases(List) lst:
    | empty => empty
    | link(fst, rst) =>
      if fst == val:
        rst
      else:
        link(fst, remove-first-found(rst, val))
      end
  end
end
 
# fill in the following check block for remove-first-found
check:
  remove-first-found([list: 15, 17, 111, 17], 17) is [list: 15, 111, 17]
 
  remove-first-found([list: 17, 111, 17], 17) is [list: 111, 17]
 
  remove-first-found([list: 111, 17], 17)     is [list: 111]
 
  remove-first-found([list: 17], 17) is           empty
 
  remove-first-found(empty, 17) is empty 
end

fun list-min(lst :: List<Number>) -> Number:
  doc: "returns the minimum value of lst. Assumes lst is not empty"
  if lst.length() == 1:
    lst.first
  else:
    rest-min = list-min(lst.rest)
    if lst.first < rest-min:
      lst.first
    else:
      rest-min
    end
  end
end

# fill in the following check block for list-min
check:
  list-min([list: 200, 33, 22, 33]) is 22
  
  list-min([list: 33, 22, 33]) is 22
  
  list-min([list: 22, 33]) is 22
  
  list-min([list: 33]) is 33
  
  # no empty case because we assume list has length at least 1
end


fun mult-by-val(lst :: List<Number>, val :: Number) -> List<Number>:
  doc: "produces a new list, with every element of lst multiplied by val"
  # note: we are not writing a check block for this function because it is analogous to that of double
  cases(List) lst:
    | empty => empty
    | link(fst, rst) => link(fst * val, mult-by-val(rst, val))
  end
end


fun mult-by-min(lst :: List<Number>) -> List<Number>:
  doc: "produces a new list, with every element of lst multiplied by the minimum value in lst"
  if lst.length() == 0:
    empty
  else:
    # we are able to call list-min because we know the list will be of length at least 1
    min = list-min(lst)
    
    mult-by-val(lst, min)
  end
end

check:
  mult-by-min([list: 9, 0, -1, 4]) is [list: -9, 0, 1, -4]
  
  mult-by-min([list: 0, -1, 4]) is [list: 0, 1, -4]
  
  mult-by-min([list: -1, 4]) is [list: 1, -4]
  
  mult-by-min([list: 4]) is [list: 16]
  
  mult-by-min(empty) is empty
end


fun wrong-mult-by-min(lst :: List<Number>) -> List<Number>:
  doc: "produces a new list, with every element of lst multiplied by the minimum value in lst"
  if lst.length() == 0:
    empty
  else:
    min = list-min(lst)
    link(lst.first * min, wrong-mult-by-min(lst.rest))
  end
end

wrong-mult-by-min([list: 9, 0, -1, 4])
# produces [-9, 0, 1, 16]