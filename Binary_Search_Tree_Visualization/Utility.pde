ArrayList<Integer> range(int limit) {
  ArrayList<Integer> elems = new ArrayList<Integer>();
  
  for (int i = 0; i < limit; i++)
    elems.add(i);
  
  return elems;
}

ArrayList<Integer> shuffle(ArrayList<Integer> arr) {
  for (int i = 0; i < arr.size(); i++) {
    int randIndex = randInt(i);
    swap(i, randIndex, arr);
  }
  
  return arr;  
}

void swap(int i, int j, ArrayList<Integer> arr) {
  int temp = arr.get(i);
  arr.set(i, arr.get(j));
  arr.set(j, temp);
}

double timePassed() {
  return 1 / frameRate;  
}

int randInt(int upper_bound) {
  return int(random(upper_bound));
}
