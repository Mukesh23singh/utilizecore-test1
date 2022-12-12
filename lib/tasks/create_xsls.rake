require 'csv'
namespace :create do
  desc "Creating xsls file"
  task xsls_file: :environment do
    begin
      file = "#{Rails.root}/public/data.xlsx"
      parcels = Parcel.all.includes([:sender, :receiver])
      headers = ["Courier", "Sender", "Receiver"]
      CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
        parcels.each do |parcel|
          writer << [["Cost #{parcel.cost}", "Weight #{parcel.weight}", "Status #{parcel.status}", "Payment_mode #{parcel.payment_mode}"].join(' '), parcel.sender.try(:name), parcel.receiver.try(:name)]
        end
      end
    end
  end
end