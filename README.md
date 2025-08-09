# NetSharp-Lang
``Write expressive, high-performance code with a familiar C#-first experience. Modern syntax, smooth tooling, and a delightful developer experience.``


NetSharp is a modern programming language designed as a superset of C#, compiling to .NET Intermediate Language (IL) for seamless interoperability with the .NET ecosystem. It enhances C# with expressive features like shared methods, typedef aliases, signal for event handling, and streamlined syntax for access modifiers, constructors, and more. NetSharp is ideal for developers seeking a familiar yet powerful language for building robust .NET applications, from console programs to GUI applications with Windows Forms.

---

## Features

- **C# Superset:** Extends C# with additional syntax while maintaining full compatibility with .NET libraries and frameworks.  
- **Shared Members:** Uses <code>shared</code> to denote static methods, fields, and constructors, replacing C#'s <code>static</code> keyword for clarity.  
- **Typedefs:** Simplifies code with <code>typedef</code> for creating aliases for types or namespaces, reducing verbosity.  
- **Signals:** Introduces <code>signal</code> for event-like notifications, offering a cleaner alternative to traditional delegates.  
- **Enhanced Syntax:** Supports concise constructor declarations (<code>this()</code>), access modifier blocks (e.g., <code>public:</code>), and keywords like <code>raise</code> for throwing exceptions.  
- **Interoperability:** Compiles to .NET IL, ensuring seamless integration with .NET libraries, including System and System.Windows.Forms.  
- **Robust Error Handling:** Provides detailed compiler diagnostics for syntax errors, unresolved identifiers, and other issues.  
- **Flexible Compiler Options:** Supports command-line options for output types (exe, library), references, and strong-name signing.  

---

## Getting Started

### Prerequisites

- .NET Runtime (version compatible with your target framework).  
- NetSharp compiler (download from official source).  
- Optional: A code editor like Visual Studio Code with C# syntax highlighting.  

### Installation

1. Download the NetSharp compiler from the official repository.  
2. Install the .NET runtime if not already present.  
3. Add the NetSharp compiler to your system PATH for easy access.  
4. Verify installation with:

<code>netsharp --help</code>

---

## Basic Example

Create a file <code>Hello.cs</code>:

<code>
class A {
  shared void Main() {
    System.Console.WriteLine("Hello, NetSharp!");
  }
}
</code>

Compile and run:

<code>
netsharp --o:Hello.exe --t:exe Hello.cs
./Hello.exe
</code>

Output:

<code>
Hello, NetSharp!
</code>

---

## Syntax and Features

### Variables and Types

<code>
class A {
  shared void Main() {
    var i = 2000000000; // Implicitly int
    string s = "Hello world!";
    Console.WriteLine(i);
    Console.WriteLine(s);
  }
}
</code>

### Comments

Supports single-line (<code>//</code>), multi-line (<code>/* */</code>), and inline comments.

<code>
class A {
  shared void Main() {
    // Single-line comment
    /* Multi-line
       comment */
    System.Console.WriteLine(/* inline */ "Hello World!");
  }
}
</code>

### Control Structures

Standard control structures like <code>if</code>, <code>while</code>, and <code>for</code>, with C#-compatible syntax.

<code>
using System;
class A {
  shared void Main() {
    int i = 5;
    if (i > 5) {
      Console.WriteLine("i is greater than 5");
    } else if (i == 5) {
      Console.WriteLine("i is equal to 5");
    }
    for (int j = 0; j < 3; ++j) {
      Console.WriteLine("iteration " + j);
    }
  }
}
</code>

### Classes and Objects

Define classes with access modifiers (<code>public</code>, <code>internal</code>) and use <code>shared</code> for static members.

<code>
public class ExplicitlyPublicClass {
}

class A {
public:
  int Length {
    get { return _len; }
    set { _len = value; }
  }
  this() {
    _len = 10;
  }
  shared void Main() {
    A a = new A();
    a.Length = 123;
    System.Console.WriteLine(a.Length);
  }
private:
  int _len;
}
</code>

### Inheritance and Polymorphism

Supports single inheritance, abstract classes, and virtual methods.

<code>
abstract class Base {
public:
  abstract void AbstractMethod();
}

class Derived(Base) {
public:
  virtual void AbstractMethod() {
    System.Console.WriteLine("Derived::AbstractMethod");
  }
}

class A {
  shared void Main() {
    Base b = new Derived();
    b.AbstractMethod();
  }
}
</code>

### Interfaces

Classes can implement multiple interfaces, with support for interface inheritance.

<code>
using System;
interface IA {
  void MethodA();
}
interface IB {
  void MethodB();
}
class A : IA, IB {
public:
  virtual void MethodA() { Console.WriteLine("A::MethodA"); }
  virtual void MethodB() { Console.WriteLine("A::MethodB"); }
  shared void Main() {
    A a = new A();
    IA ia = a;
    ia.MethodA();
  }
}
</code>

### Delegates and Signals

Define delegates with function and use <code>signal</code> for event handling.

<code>
using System;
function void ClickHandler(object sender);

class A {
public:
  signal ClickHandler OnClick;
  void MouseClicked() {
    if (OnClick != null)
      OnClick.Invoke(this);
  }
}

class M {
  shared void Main() {
    A a = new A();
    a.add_OnClick(new ClickHandler(MyClickHandler));
    a.MouseClicked();
  }
  shared void MyClickHandler(object sender) {
    Console.WriteLine("Sender object " + sender);
  }
}
</code>

### Namespaces and Typedefs

Organize code with nested namespaces and simplify with <code>typedef</code>.

<code>
using System;
typedef C = Console;

namespace Ns {
  class MyClass {
  public:
    void Method() { C.WriteLine("MyClass::Method"); }
  }
}

class A {
  shared void Main() {
    C.WriteLine("a");
    new Ns.MyClass().Method();
  }
}
</code>

### Exception Handling

Use <code>try</code>, <code>catch</code>, <code>finally</code>, and <code>raise</code> for custom exceptions.

<code>
using System;
class MyException(ApplicationException) {
public:
  this(string msg) : base(msg) {}
}

class A {
public:
  shared void Main() {
    try {
      raise new MyException("Error code: 123");
    } catch(MyException e) {
      Console.Error.WriteLine("catch: " + e);
    }
  }
}
</code>

### Arrays and Structs

Support for arrays and lightweight struct types.

<code>
struct S {
  this(int i) { this.i = i; }
  int i;
}

class A {
  shared void Main() {
    int[] arr = new int[100];
    arr[0] = 1;
    arr[1] = arr[0] + 2;
    Console.WriteLine(arr[1]);
    new S(42);
  }
}
</code>

### Operators

Includes compound assignments and null coalescing (<code>??</code>).

<code>
class A {
  shared void Main() {
    int i = 1;
    i += 5; // 6
    A a = null;
    A c = new A();
    A d = a ?? c;
    System.Console.WriteLine(i);
  }
}
</code>

### Singleton Pattern

Implement singletons using <code>shared</code> members.

<code>
class Singleton {
public:
  shared Singleton GetInstance() {
    if (instance == null)
      instance = new Singleton();
    return instance;
  }
private:
  this() {}
  shared Singleton instance;
}
</code>

### Windows Forms

Create GUI applications with Windows Forms.

<code>
using System;
using System.Windows.Forms;

class MainWindow(Form) {
public:
  this() {
    this.Width = 500;
    this.Text = "My first window";
    this.button = new Button();
    this.button.Text = "Click Me";
    this.button.add_Click(new EventHandler(OnClick));
    this.Controls.Add(button);
  }
family:
  void OnClick(object sender, EventArgs e) {
    MessageBox.Show("Clicked!");
  }
private:
  Button button;
}

class A {
  shared void Main() {
    Application.Run(new MainWindow());
  }
}
</code>

---

## Compiler Options

NetSharp's compiler supports various command-line options:

- <code>--o:&lt;filename&gt;</code>: Specify output file (e.g., MyProgram.exe).  
- <code>--t:&lt;type&gt;</code>: Set output type (<code>exe</code> for executable, <code>library</code> for DLL).  
- <code>--ref:&lt;assembly&gt;</code>: Reference external assemblies (e.g., System.dll).  
- <code>--kf:&lt;keyfile&gt;</code>: Sign the assembly with a strong-name key.  
- <code>--help</code>: Display all available options.

Example:

<code>
netsharp --o:MyProgram.exe --t:exe MyProgram.cs
netsharp --t:library --ref:System.Windows.Forms.dll MyLibrary.cs
</code>

---

## Error Handling

The NetSharp compiler provides detailed diagnostics:

<code>
class A {
  shared void Main() {
    int x = 5 // Missing semicolon
  }
}
// Compiler output: [High Error] Syntax (Line 3, Column 15):
// Syntax violation detected: Missing semicolon
// Fix: Add a semicolon, e.g., `int x = 5;`.
</code>

---

## Limitations

- Single inheritance only (like C#).  
- Some advanced .NET features (e.g., async/await) may require standard C# syntax.  
- Limited documentation on certain edge cases; refer to the official docs for updates.  

---

## Contributing

Contributions are welcome! Submit issues, feature requests, or pull requests to the NetSharp repository. Ensure code follows the NetSharp style guide and includes tests.

---

## Documentation

Visit the NetSharp Documentation for detailed guides on syntax, control structures, classes, and advanced features.

---

## License

MIT License
