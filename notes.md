# Creating a RSpec Gem Clone

In this project I create a RSpec gem clone, adding functionality as I go. I will use RSpec to test it.

### Installing Rspec

In the Gemfile, add `gem "rspec", "~> 3.0"`.

The specifier ~> means that you will get the highest released version of the Gem between 3.0 and 4.0.

If you specified a minor version, e.g. "~> 3.1.0" you would get the highest released version between 3.1.0 and 3.2

### Using class_eval and instance_eval

When writing a test, we call `RSpec.describe` with a block. Inside this block, we expect to have access to methods called `context` and `it`.

```ruby
FooSpec.describe 'Initial describe block' do
  context 'When something is like something' do
    it 'does something' do
      expect(42).to eq(42)
    end
  end
end
```

However we don't automatically have access to these. If we simply yield to the block, we get an error: `undefined method `context' for main:Object (NoMethodError)`

We need to define the method `to` on the class `FooSpec` and evaluate the block within the context of the `FooSpec` class. This can be done with the `FooSpec.class_eval` method.

`class_eval` executes code in the context of the class in question. I.e. as though the class were "open" at creation time. A common example is:

```ruby
class Person
end

Person.class_eval do
  def greet
    puts 'Hello!'
  end
end

p = Person.new
p.greet # 'Hello!'
```

A sister of `class_eval` is `instance_eval`, which executes code in the context of an instance.

```ruby
class Person
end

Person.instance_eval do
  def greet
    puts 'Hello!'
  end
end


Person.greet # 'Hello!'
```

In this example, the block is evaluated on the Person instance - remember that a class name is simply a constant which points to an instance of the class Class - so when we evaluate the block in the above example, defining greet within the Person instance creates a class method.

## Instance methods Vs Class methods

Instance methods are defined on a class and apply to instances of that class.

For example, we can say that the class **Class has instance methods** of `new`, `superclass` and `allocate`.

`Class.instance_methods false` (false means ignore inherited methods)

We can say that a class called **Person, for example, has methods of** `new`, `superclass`, `allocate`.

The same goes for instances. E.g.:

```ruby
p = Person.new
p.greet
```

We can say that `p` has a method of `greet`, meaning it will respond to `greet` but we would say that the Person class has an instance method of `greet`.

Class methods on the other hand are methods you call on a class itself, not an instance. E.g.

```ruby
class Person
  def self.greet
    puts 'Hello'
  end
end

Person.greet
```

Here, `greet` is a Class method.

## Classes V Modules

Classes and Modules are actually very similar, almost the same, in Ruby (`Module.class === Class`). You could use them interchangeably but it is best to use a class when you intend to create instances, and modules when you intend the functionality to be included somewhere else.

The names of modules/classes e.g. 'FooSpec' are **constants** which point to an instance of Class or Module. For example, `String` points to an instance of `Class` with all the string methods/behaviour.

You can mess up Ruby by changing the reference a constant points to, e.g. `String = 'hello'`.

Classes and modules can be nested within one another, e.g.

```ruby
class FooSpec
  class Matcher
    class Eq
      attr_reader :value
      def initialize(value)
        @value = value
      end
    end
  end
end
```

Whereby the `Eq` class can be referenced with its **path** which is `FooSpec::Matcher::Eq`

## Throw/Catch vs Raise/Rescue

Raising and error and rescuing should be used when something goes wrong in the program.

Throw/Catch offers a way of escaping from nested control flow, i.e. a loop in a loop, which you want to break out of early by throwing.

