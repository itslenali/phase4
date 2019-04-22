class Flavor < ApplicationRecord

#Flavors must:

#1. have all proper relationships specified
  has_many :store_flavors
  has_many :stores, through: :store_flavors
  
#2. have a name
  validates_presence_of :name

#3. have the following scopes:
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { order(:name) }

#4. can never be deleted, only made inactive
  before_destroy :destroyable?
  after_rollback :convert_inactive

# helper functions for destroy

#  private
  def destroyable?
    @destroyable = false
    #convert_inactive
    return "Denied"
  end
  
  def convert_inactive
    self.update_attribute(:active, false) if !@destroyable.nil? 
    @destroyable = nil
    return "Changed to inactive"
  end

 
end
