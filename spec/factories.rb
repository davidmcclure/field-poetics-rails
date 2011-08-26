Factory.define :administrator do |administrator|
  administrator.username "davidmcclure"
  administrator.email "david.mcclure@virginia.edu"
  administrator.password "scholarslab"
  administrator.password_confirmation "scholarslab"
  administrator.firstname "David"
  administrator.lastname "McClure"
  administrator.is_superadmin 1
end
