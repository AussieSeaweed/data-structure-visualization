/* A Processing Program that visualizes the Binary Search Tree Data Structure.
 * Written by Juho Kim.
 */

import java.util.*;

BST<Integer> bst = new BST<Integer>();
int numElems = 30;
ArrayList<Integer> elems = shuffle(range(numElems));
int index = 0;
double frequency = .05;
double counter = frequency;

boolean paused = false;
boolean completed = false;

void setup() {
  size(1000, 800);
  frameRate(2000);
  
  textAlign(CENTER, CENTER);
  background(255);
}

void draw() {
  if (!paused) {
    counter -= timePassed();
    
    if (counter <= 0) {
      int operation = int(random(2)); // 0: insertion, 1: deletion
      
      if (!elems.isEmpty() && (operation == 0 || !completed) || bst.size() < numElems * 0.75 || bst.size() == 0) {  // insertion
        bst.insert(elems.remove(elems.size() - 1));
      } else {  // deletion
        completed = true;
        int randomElem = bst.get(int(random(bst.size())));
        bst.delete(randomElem);
        elems.add(randomElem);
      }
      counter = frequency;
    }
  }
    
  background(255);
  bst.display();
}

void keyTyped() {
  paused = !paused;  
}

void mouseClicked() {
  paused = !paused;  
}
