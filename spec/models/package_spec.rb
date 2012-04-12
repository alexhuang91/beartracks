require 'spec_helper'

describe Package do
  before :each do
    @empty_package = Package.new()
    @filled_package = Package.new(:resident_name => "Case", :clerk_id => 1, :unit => "Unit 1",
        :building => "Cheney", :room => 12, :tracking_number => 1212333)
    @partially_filled_package = Package.new(:resident_name => "Reilly", :room => 343)
    @never_null_fields = {:resident_name=>'Resident Name', :unit=>'Unit', :building=>'Building',
      :room=>'Room',:tracking_number=>'Tracking Number'} # copied from package.rb
  end

  describe 'unfilled fields' do
    describe 'give back an array with the missing fields' do
      it 'should be nil if fields are filled' do
        array = @filled_package.unfilled_fields
        array.empty?
      end

      it 'should have some fields if some are not specified' do
        array = @partially_filled_package.unfilled_fields
        array.empty? == false and not array.include? :unit
      end

      it 'should have all fields if none of the fields are filled' do
        array = @empty_package.unfilled_fields
        all_here = true
        @never_null_fields.each_key do |field|
          if not array.include? field
            all_here = false
          end
        end
        all_here == true
      end
    end
  end

  describe 'has required fields' do
    it 'should retun true if package has all fields' do
      @filled_package.has_required_fields == true
    end

    it 'should return false if package has some fields' do
      @partially_filled_package.has_required_fields == false
    end

    it 'should return false if package has no fields' do
      @empty_package.has_required_fields == false
    end
  end

  describe 'blank fields' do
    describe 'returns a string' do
      it 'should be a verbose "No" if package has all fields' do
        @filled_package.blank_fields == "(nothing left blank, bad usage)"
      end

      it 'should be a comma-separated list of the missing fields if it has some fields' do
        string = @partially_filled_package.blank_fields
        string == "Unit, Building, or Tracking Number"
      end
    end
  end
end
