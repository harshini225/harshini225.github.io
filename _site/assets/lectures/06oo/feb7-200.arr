use context essentials2021

data BinTree<a>:
  | empty-tree
  | bin-tree(val :: a,
      lt-tree :: BinTree<a>,
      rt-tree :: BinTree<a>)
end

tree-B = 
  bin-tree(15,
    bin-tree(33,
      empty-tree,
      empty-tree),
    empty-tree)

tree-C =
  bin-tree(111,
    empty-tree,
    bin-tree(112,
      empty-tree,
      bin-tree(200,
        empty-tree,
        empty-tree)))

fun tree-ht(bin-t :: BinTree) -> Number:
  cases(BinTree) bin-t:
    | empty-tree => 0
    | bin-tree(v, l-t, r-t) =>
      1 + num-max(tree-ht(l-t), tree-ht(r-t)) 
  end  
end

check:
  tree-ht(empty-tree) is 0
  tree-ht(tree-B) is 2
  tree-ht(tree-C) is 3
end

our-bst =
  bin-tree(5,
    bin-tree(3,
      bin-tree(1, empty-tree, empty-tree),
      bin-tree(4, empty-tree, empty-tree)),
    bin-tree(10,
      bin-tree(7, empty-tree, empty-tree),
      bin-tree(11, empty-tree, empty-tree)))

fun find-in-bst(val :: Number,
    bst :: BinTree<Number>) -> Boolean:
  doc: "determines if val is in the BST"
  
  cases(BinTree) bst:
    | empty-tree => false
    | bin-tree(root-val, l-t, r-t) =>
      if val < root-val:
        find-in-bst(val, l-t)
      else if val > root-val:
        find-in-bst(val, r-t)
      else: # val == root-val
        true
      end
  end
end

fun add-to-bst(val :: Number,
    bst :: BinTree<Number>) -> BinTree<Number>
  doc: "produces a new BST with val added to bst, obeying BST rules"
  
  cases(BinTree) bst:
    | empty-tree => bin-tree(val, empty-tree, empty-tree)
    | bin-tree(root-val, l-t, r-t) =>
      if val < root-val:
        add-to-bst(val, l-t)
      else:
        add-to-bst(val, r-t)
      else: # already in bst
        bst
      end
  end
end