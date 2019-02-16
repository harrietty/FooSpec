class FooSpec
  def self.describe(description, &block)
    puts description
    FooSpec.class_eval &block
  end

  def self.context(description, &block)
    puts description
    FooSpec.class_eval &block
  end

  def self.it(description, &block)
    puts description
    begin
      TestCase.class_eval &block
      puts 'PASS'
    rescue FailedTestCase => e
      puts 'FAIL'
    end
  end
end

class FooSpec
  class TestCase
    def self.expect(actual)
      Actual.new actual
    end

    def self.eq(expected)
      Matcher::Eq.new expected
    end
  end
end

class FooSpec
  class Actual
    def initialize(value)
      @actual = value
    end

    def to(matcher)
      matcher.eval(@actual)
    end
  end
end

class FooSpec
  class Matcher
    class Eq
      def initialize(value)
        @value = value
      end

      def eval(actual)
        raise FailedTestCase unless @value === actual
      end
    end
  end
end

class FooSpec
  class FailedTestCase < Exception
  end
end
