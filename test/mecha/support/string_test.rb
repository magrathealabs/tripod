require 'test_helper'

class StringTest < Minitest::Test
  test 'from camelcase' do
    assert_equal 'snake_case', 'SnakeCase'.underscore
  end

  test 'from camelcase containing a dash' do
    assert_equal 'snake_case', 'Snake-Case'.underscore
  end

  test 'from camelcase containing spaces' do
    assert_equal 'snake_case', 'Snake  Case'.underscore
  end

  test 'from camelcase containing underscores' do
    assert_equal 'snake_case', 'Snake__Case'.underscore
  end
end
