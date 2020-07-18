class User < ApplicationRecord
    has_many :attendances, dependent: :destroy

    def serchDay(first, last)
        self.attendances.where(worked_on: first .. last).order(id: :ASC)
    end
end
