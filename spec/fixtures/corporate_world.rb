# -*- coding: utf-8 -*-

module DataMapper
  module Validations
    module Fixtures
      class Organisation
        include DataMapper::Resource

        property :id, Serial
        property :name, String
        property :domain, String, :unique_index => true

        validates_uniqueness_of :domain, :allow_nil => true
      end

      class Department
        include DataMapper::Resource

        property :id, Serial
        property :name, String, :unique_index => true
        property :type, Discriminator

        validates_uniqueness_of :name
      end

      class User
        include DataMapper::Resource

        property :id, Serial
        property :user_name, String

        belongs_to :organisation
        belongs_to :department

        validates_uniqueness_of :user_name, :when => :signing_up_for_department_account,   :scope => [:department]
        validates_uniqueness_of :user_name, :when => :signing_up_for_organization_account, :scope => [:organisation]
      end

      # For STI uniqueness testing
      class BigDepartment < Department; end
    end
  end
end
