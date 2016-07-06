class AdminUser < ActiveRecord::Base

	#razlicito ime tablice u bazi od klase, pa moramo klasi pokazati razlicito ime
	#self.table_name = "admin_user"

	#ako koristimo Ruby on Rails konveniju, ona već sama ukljuci sve stupce kao varijable i 
	#netrebaju na get i set(dobiveno od ActiveRecord)

	has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits
	

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	KORISNICKA_IMENA = ['josip', 'franjo']

	validates_presence_of :first_name
	validates_length_of :first_name, :maximum => 25
	validates_presence_of :last_name
	validates_length_of :last_name, :maximum => 50
	validates_presence_of :username
	validates_length_of :username, :within => 8..25
	validates_uniqueness_of :username
	validates_presence_of :email
	validates_length_of :email, :maximum => 100
	validates_format_of :email, :with => EMAIL_REGEX
	validates_confirmation_of :email

	#kraće zapisane validacije
	#validates :first_name, :presence => true,
	#						:lenght => {:maximum=>25}

	#validates :last_name, :presence => true,
	#						:lenght=>{ :maximum =>50 }

	#validates :username, :lenght =>{:within=>8..25},
	#					:uniqueness => true

	#validates :email, :presence =>true,
	#					:lenght=>{:maximum=>100},
	#					:format => EMAIL_REGEX,
	#					:confirmation => true


	validate :username_is_dozvoljen

	scope :sorted, lambda{order("last_name ASC, first_name ASC")}

	def name
		first_name +  ' ' + last_name	
	end
	def username_is_dozvoljen
		if KORISNICKA_IMENA.include?(username)
			errors.add(:username, "has been restricted from use.")
		end		
	end

end
