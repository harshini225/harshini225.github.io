import math

"""implementation of a max heap"""
class Heap:
    def __init__(self):
        self.data = []
        self.size = 0

    def __str__(self):
        """string representation is the underlying list"""
        return str(self.data)

    def parent_index(self, of_index):
        """compute parent index of given index. Assumes of_index > 0"""
        return math.floor((of_index - 1) / 2)

    def swap(self, index1, index2):
        """swaps values in index1 and index2 within self.data""" 
        tmp = self.data[index1]
        self.data[index1] = self.data[index2]
        self.data[index2] = tmp

    def insert(self, new_elt):
        """insert element into the heap"""
        self.data.append(new_elt)
        self.size = self.size + 1
        self.sift_up(self.size - 1)

    def sift_up(self, from_index):
        """swap element in from_index up heap until it is in the right place"""
        if from_index > 0:
            parent = self.parent_index(from_index)
            if self.data[from_index] > self.data[parent]:
                self.swap(parent, from_index)
                self.sift_up(parent)

    def sift_up_while(self, from_index):
        """a while-loop based version of sift_up"""
        if from_index > 0:
            curr_index = from_index
            parent = self.parent_index(curr_index)
            while (curr_index > 0) and \
                  (self.data[curr_index] > self.data[parent]):
                self.swap(parent, curr_index)
                curr_index = parent
                parent = self.parent_index(curr_index)
                # note that the while loop version repeats these
                #  last two lines, unlike the recursive version

    
# An example heap    
h = Heap()
h.insert(7)
h.insert(3)
h.insert(9)
h.insert(4)
print(str(h))

h.insert(1)
h.insert(12)
h.insert(8)
h.insert(6)
print(str(h))

"""
Study Questions
- Where would the code change to make this a min heap
  instead of a max heap?

- Where would the code change to make this a heap
  that prioritized strings alphabetically?

- How would we make this class flexible to different
  data and priorities without modifying the code
  every time?

- Why doesn't sift_up (or sift_up_while) return anything?

- what methods would you expect to add to remove
  the priority element from the heap?

"""