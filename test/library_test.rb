require 'minitest/autorun'
require 'minitest/pride'
require './lib/book.rb'
require './lib/author.rb'
require './lib/library.rb'

class LibraryTest < Minitest::Test
  def setup
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @dpl = Library.new("Denver Public Library")
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  def test_it_exists
    assert_instance_of Library, @dpl
  end

  def test_it_has_a_name
    assert_equal "Denver Public Library", @dpl.name
  end

  def test_it_starts_with_no_books_or_authors
    assert_equal [], @dpl.books
    assert_equal [], @dpl.authors
  end

  def test_it_can_add_authors
    @dpl.add_author(@charlotte_bronte)
    assert_equal [@charlotte_bronte], @dpl.authors

    @dpl.add_author(@harper_lee)
    assert_equal [@charlotte_bronte, @harper_lee], @dpl.authors

    assert_equal [@jane_eyre,@professor, @villette, @mockingbird], @dpl.books
  end

  def test_it_can_give_authors_publication_time_frame
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    assert_equal ({:start => "1847", :end => "1857"}), @dpl.publication_time_frame_for(@charlotte_bronte)
    assert_equal ({:start => "1960", :end => "1960"}), @dpl.publication_time_frame_for(@harper_lee)
  end
end
