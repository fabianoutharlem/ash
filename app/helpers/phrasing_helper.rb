module PhrasingHelper
  # You must implement the can_edit_phrases? method.
  # Example:
  #
  def can_edit_phrases?
   current_user.present?
  end
end
