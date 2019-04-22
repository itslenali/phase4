class Job < ApplicationRecord
    
#Jobs must:
#1. have all proper relationships specified
    has_many :shift_jobs
    has_many :shifts, through: :shift_jobs

#2. have a name
  validates_presence_of :name

#3. have the following scopes:
#a) 'active' -- returns only active jobs
    scope :active,       -> { where('active= ?', true) }

#b) 'inactive' -- returns all inactive jobs
    scope :inactive,     -> { where('active=?', false) }
    
#c) 'alphabetical' -- orders results alphabetically
    scope :alphabetical, -> { order('name') }

#4. can only be deleted if the job has never been worked by an employee; otherwise it is made inactive
  before_destroy :is_destroyable?
  after_rollback :convert_inactive


#-----HELPER FUNCTIONS-----

  private
  
  def is_destroyable?
    @destroyable = self.shift_jobs.empty?
  end
  
  def convert_inactive
    self.update_attribute(:active, false) if !@destroyable.nil? && @destroyable == false
    @destroyable = nil
  end

end
