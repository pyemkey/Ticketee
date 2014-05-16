class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  mount_uploader :asset, AssetUploader
  has_many :permissions, as: :thing

  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "create tickets",
                                             user_id: user.id })
  end

  scope :for, ->(user) { user.admin? ? Ticket.all : Ticket.viewable_by(user) }
end
