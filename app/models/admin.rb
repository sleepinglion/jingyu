class Admin < ApplicationRecord
    self.table_name = 'users'
    devise :database_authenticatable, :registerable, :trackable, :validatable, :timeoutable
    validates_length_of :login_id, within: 4..40
    default_scope {where(:admin => true)}

    def timeout_in
        1.day
    end
end
