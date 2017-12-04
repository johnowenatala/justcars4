class Order < ActiveRecord::Base

  enum :status => { created: 1, assigned: 12, resolved: 23}

  belongs_to :car

end
