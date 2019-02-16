require './lib/foospec.rb'

FooSpec.describe 'Initial describe block' do
  context 'When something is like something' do
    it 'does something' do
      expect(42).to eq(42)
    end
  end
end
