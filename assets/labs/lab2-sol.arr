#lab02-15 SOLUTION

# Provided datatype

data BinTree2:
  | leaf(value :: Number)
  | node(value :: Number, left :: BinTree2, right :: BinTree2)
end

# === Task 1: produce the height of the longest path down the tree ===

fun tree-depth(bin-tree :: BinTree2) -> Number:
  doc: "Produces the height of the longest path down the tree"
  cases(BinTree2) bin-tree:
    | leaf(v) => 1
    | node(v, l, r) =>
      num-max(tree-depth(l), tree-depth(r)) + 1
  end
end

# === Task 3: does tree have element? ===

fun has-elt(bst :: BinTree2, val :: Number) -> Boolean:
  doc: "Produces true if bst has val, false otherwise"
  cases(BinTree2) bst:
    | leaf(v) => v == val
    | node(v, l, r) =>
      if val == v:
        true
      else if val < v:
        has-elt(l, val)
      else:
        has-elt(r, val)
      end
  end
end

# === Task: fix runtime annotation ===
#|
fun add-elt(bst :: BinTree1, val :: Number) -> BinTree1:
  doc: "adds val to bst, obeying Binary Search Tree rules"
  cases(BinTree1) bst: # 1 access
    | empty => node(val, emptytree, emptytree)  # not the worst case
    | node(v, l-tree, r-tree) => # 1 comparison, 3 assignments
      if val == v:    # 2 accesses, 1 operator
        bst    # not the worst case
      else if val < v: # 2 accesses, 1 operator
        add-elt(l-tree, val) # T-add-elt(N - 1), 2 accesses, 1 function call
      else:
        add-elt(r-tree, val) # T-add-elt(N - 1), 2 accesses, 1 function call
      end
  end
end
# Total: T-add-elt(N) = 1 + 4 + 3 + 3 + 3 + T-add-elt(N-1)
# Total: T-add-elt(N) = 14 + T-add-elt(N-1)
|#

# === Task: expression tree ===

data Expression:
  | num(n :: Number)
  | neg(e :: Expression)
  | add(e1 :: Expression, e2 :: Expression)
  | sub(e1 :: Expression, e2 :: Expression)
  | mul(e1 :: Expression, e2 :: Expression)
  | div(e1 :: Expression, e2 :: Expression)
end

# === Task: expressions as Expression trees ===

expr1 = num(5)

expr2 = add(
  num(3), 
  add(
    num(2), 
    num(4)))

expr3 = mul(
  add(
    num(4), 
    num(5)),
  sub(
    num(7),
    num(2)))

expr4 = sub(
  num(6),
  mul(
    neg(num(4)),
    sub(
      num(8),
      num(2))))

# === Task: expression tree calculation

fun calc(expr :: Expression) -> Number:
  cases(Expression) expr:
    | num(n) => n
    | neg(e) => -1 * calc(e)
    | add(e1, e2) => calc(e1) + calc(e2)
    | sub(e1, e2) => calc(e1) - calc(e2)
    | mul(e1, e2) => calc(e1) * calc(e2)
    | div(e1, e2) => calc(e1) / calc(e1)
  end
end

check:
  calc(expr1) is 5
  calc(expr2) is 9
  calc(expr3) is 45
  calc(expr4) is 30
end
