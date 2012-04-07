class Package < ActiveRecord::Base
  belongs_to :clerk

  def unfilled_fields
    @@never_null_fields = {:resident_name=>'Resident Name', :unit=>'Unit', :building=>'Building',
      :room=>'Room',:tracking_number=>'Tracking Number'} #leaving datetime_received out, not for user
    empty_fields = @@never_null_fields.keys.
      collect{ |field| field if (not self[field] or self[field].to_s.gsub(/[\s]/,'')=="") }.
      compact
  end

  def has_required_fields
    self.unfilled_fields.length == 0
  end

  def blank_fields
    return "(nothing left blank, bad usage)" if self.has_required_fields
    fields = self.unfilled_fields
    field_strings = fields.collect { |f| @@never_null_fields[f] }
    field_strings[-1] = 'or '+field_strings[-1] if fields.length > 1
    string = field_strings.join(', ')
  end
end
