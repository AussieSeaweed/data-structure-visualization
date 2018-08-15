class BST<T extends Comparable> {
  private class Node {
    public T value;
    public Node left;
    public Node right;
    
    /*
     * variables unrelated to the functionality of Binary Search Tree
     */
    
    public float x;
    public float y;
    public int depth;
    
    public Node(T value, Node left, Node right) {
      this.value = value;
      this.left = left;
      this.right = right;
    }
  }
  
  private int size;
  private Node root;
  
  public BST() {
    size = 0;
    root = null;
  }
  
  private Node insert(T value, Node node) {
    if (node == null) {
      size++;
      return new Node(value, null, null);
    }
    
    int cmp = value.compareTo(node.value);
    
    if (cmp == 1) {
      node.right = insert(value, node.right);
    } else if (cmp == -1) {
      node.left = insert(value, node.left);
    } else/* if (cmp == 0) */{
      node.value = value;
    }
    
    return node;
  }
  
  public void insert(T value) {
    root = insert(value, root);
  }
  
  /*
   * This implements the Hibbard Deletion.
   */
  
  private Node delete(T value, Node node) {
    if (node == null) return null;
    
    int cmp = value.compareTo(node.value);
    
    if (cmp == 1) {
      node.right = delete(value, node.right);
    } else if (cmp == -1) {
      node.left = delete(value, node.left);
    } else/* if (cmp == 0) */{
      if (node.right == null) {
        node = node.left;
      } else if (node.left == null) {
        node = node.right;
      } else {
        // A flaw of hibbard deletion is that it causes a tree to be leaning to one side. So I will randomize the operation.
        int operation = int(random(2));

        if (operation == 0) {
          node.right = detachMin(node.right);
          
          Node tmp = detachedNode;
          
          tmp.left = node.left;
          tmp.right = node.right;
          
          node = tmp;
        } else {
          node.left = detachMax(node.left);
          
          Node tmp = detachedNode;
          
          tmp.left = node.left;
          tmp.right = node.right;
          
          node = tmp;
        }
        detachedNode = null;  // To prevent future loitering.
      }
      
      size--;
    }
    
    return node;
  }
  
  private Node detachedNode;
  
  private Node detachMin(Node node) {
    if (node.left == null) {
      detachedNode = node;
      return node.right;
    }
    
    node.left = detachMin(node.left);
    
    return node;
  }
  
  private Node detachMax(Node node) {
    if (node.right == null) {
      detachedNode = node;
      return node.left;
    }
    
    node.right = detachMax(node.right);
    
    return node;
  }
  
  public void delete(T value) {
    root = delete(value, root);
  }
  
  public boolean contains(T value) {
    Node node = root;
    
    while (node != null) {
      int cmp = value.compareTo(node.value);
      
      if (cmp == 1) {
        node = node.right;
      } else if (cmp == -1) {
        node = node.left;
      } else/* if (cmp == 0) */{
        return true;
      }
    }
    
    return false;
  }
  
  public int size() {
    return size;
  }
  
  private int maxHeight(Node node, int currentHeight) {
    if (node == null) return currentHeight;
    
    int leftMaxHeight = maxHeight(node.left, currentHeight + 1);
    int rightMaxHeight = maxHeight(node.right, currentHeight + 1);
    
    return (leftMaxHeight > rightMaxHeight ? leftMaxHeight : rightMaxHeight);
  }
  
  public int maxHeight() {
    return maxHeight(root, 0);
  }
  
  private ArrayList<Node> nodes;
  
  private void traverse(Node node, int depth) {
    if (node == null) return;
    
    traverse(node.left, depth + 1);
    nodes.add(node);
    node.depth = depth;
    traverse(node.right, depth + 1);
  }
  
  public void traverse() {
    nodes = new ArrayList<Node>();
    
    traverse(root, 1);
  }
  
  private T get(int rank) {
    traverse();
    return nodes.get(rank).value;
  }
  
  /*
   * Displaying the Binary Search Tree
   */
  
  private float xUnit;
  private float yUnit;
  private float diameter;
  
  private void storeCoords() {
    for (int i = 0; i < size(); i++) {
      float x = xUnit * (i + 1);
      float y = yUnit * nodes.get(i).depth;
      
      nodes.get(i).x = x;
      nodes.get(i).y = y;
    }
  }
  
  private void displayEdges(Node node) {
    if (node.left != null) {
      line(node.left.x, node.left.y, node.x, node.y);
      displayEdges(node.left);
    }
    
    if (node.right != null) {
      displayEdges(node.right);
      line(node.right.x, node.right.y, node.x, node.y);
    }
  }
  
  private void displayEdges() {
    if (root != null)
      displayEdges(root);
  }
  
  private void displayNodes() {
    for (Node node : nodes) {
      fill(255);
      ellipse(node.x, node.y, diameter, diameter);
      fill(0);
      text((int) node.value, node.x, node.y);
    }
  }
  
  public void display() {
    xUnit = ((float) width) / (size() + 1);
    yUnit = ((float) height) / (maxHeight() + 1);
    diameter = min(xUnit, yUnit);
    
    traverse();
    storeCoords();
    
    stroke(0);
    strokeWeight(3);
    textSize(diameter / 2);
    
    displayEdges();
    displayNodes();
  }
}
