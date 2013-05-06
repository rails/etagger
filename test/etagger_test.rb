require 'rubygems'
require 'bundler/setup'
require 'minitest/unit'
MiniTest::Unit.autorun

require 'etagger'

class EtaggerTest < MiniTest::Unit::TestCase
  class FakeController
    module Freshness
      def fresh_when(record_or_options, additional_options = nil)
        record_or_options[:etag]
      end
    end
    include Freshness

    include Etagger
    etag { nil  }
    etag { 'ab' }
    etag { :cde }
    etag { [:f] }
    etag { nil  }
  end

  def setup
    @controller = FakeController.new
  end

  def test_revises_etag
    assert_equal ['123', 'ab', :cde, [:f]], @controller.fresh_when(etag: '123')
  end

  def test_updated_at_with_array
    assert_equal [%w(1 2), 'ab', :cde, [:f]], @controller.fresh_when(%w(1 2))
  end
end
