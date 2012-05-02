class ConvertSplitNames < ActiveRecord::Migration
  def up
    Package.all.each do |x|
      full = x.resident_name
#temp = full.split(" ")
      if (full)
        temp = full.split(" ")
        if (temp.length > 1)
          x.resident_first_name = temp[0]
          x.resident_last_name = temp[1..temp.length - 1].join(" ")
          x.save
        else
          x.resident_first_name = full
          x.resident_last_name = "N/A"
          x.save
        end
        end
      end
      end

  def down
  end
  end
