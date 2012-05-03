require 'spec_helper'

describe Package do
  before :each do
    @empty_package = Package.new()
    @filled_package = Package.new(:resident_first_name => "Case", :resident_last_name => "Walker", :clerk_id => 1, :unit => "Unit 1",
        :building => "Cheney", :room => 12, :tracking_number => 1212333)
    @partially_filled_package = Package.new(:resident_first_name => "Reilly", :resident_last_name => "Cool", :room => 343)
    @never_null_fields = {:resident_first_name=>'Resident First Name', :resident_last_name => 'Resident Last Name', :unit=>'Unit', :building=>'Building',
      :room=>'Room',:tracking_number=>'Tracking Number'} # copied from package.rb
  end

  describe 'unfilled fields' do
    describe 'give back an array with the missing fields' do
      it 'should be nil if fields are filled' do
        array = @filled_package.unfilled_fields
        array.empty?.should == true
      end

      it 'should have some fields if some are not specified' do
        array = @partially_filled_package.unfilled_fields
        array.empty?.should == false and
        array.include?(:unit).should == true and
        array.include?(:room).should == false
      end

      it 'should have all fields if none of the fields are filled' do
        array = @empty_package.unfilled_fields
        all_here = true
        @never_null_fields.each_key do |field|
          if not array.include? field
            all_here = false
          end
        end
        all_here.should == true
      end
    end
  end

  describe 'has required fields' do
    it 'should retun true if package has all fields' do
      @filled_package.has_required_fields.should == true
    end

    it 'should return false if package has some fields' do
      @partially_filled_package.has_required_fields.should == false
    end

    it 'should return false if package has no fields' do
      @empty_package.has_required_fields.should == false
    end
  end

  describe 'blank fields' do
    describe 'returns a string' do
      it 'should be a verbose "No" if package has all fields' do
        @filled_package.blank_fields.should == "(nothing left blank, bad usage)"
      end

      it 'should be a comma-separated list of the missing fields if it has some fields' do
        string = @partially_filled_package.blank_fields
        string.should == "Unit, Building, or Tracking Number"
      end
    end
  end
end
