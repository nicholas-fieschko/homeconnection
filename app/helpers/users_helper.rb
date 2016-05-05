module UsersHelper

  def can_view_resource_info?
    @user.field_viewable_by?(:resources, current_user) && @user.field_viewable_by?( :resources_info, current_user)
  end

  def authorized_email_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:email, current_user)
      viewed_user.email
    else
      "(hidden)"
    end
  end

  def authorized_activity_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:activity, current_user) && 
      !viewed_user.last_sign_in_at.nil?
      "#{time_ago_in_words viewed_user.last_sign_in_at} ago"
    else
      "(hidden)"
    end
  end

  def authorized_location_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:location, current_user)
      location_string viewed_user
    else
      "(hidden)"
    end
  end

  def authorized_resources_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:resources, current_user)
      resources_string(viewed_user).gsub(', ',' - ').upcase
    else
      "(hidden)"
    end
  end

  def authorized_age_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:age, current_user) && 
      !viewed_user.birthday.nil?
      time_ago_in_words viewed_user.birthday
    else
      "(hidden)"
    end
  end

  def authorized_gender_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:gender, current_user) && 
      !viewed_user.gender.nil?
      viewed_user.gender.capitalize
    else
      "(hidden)"
    end
  end

  def authorized_about_string(viewed_user=@user)
    if viewed_user.field_viewable_by?(:about, current_user)
      viewed_user.about
    else
      "(hidden)"
    end
  end


  def authorized_private_review_string(review, viewed_user=@user)
    if current_user.id != review.user_id
      review.private_comments
    else
      ""
    end
  end

  def privacy_options
    [["Only myself", 0],
     ["Those in an exchange that I have initiated or accepted", 1],
     ["Resource #{current_user.provider? ? 'seekers' : 'providers'}", 2],
     ["All signed in users", 3],
     ["Anyone", 4]]
  end


  def location_string(user)
    [user.city, user.state, user.country].reject(&:blank?).join(', ')
  end

  def resources_string(user)
    resources = []
    resources << "food"           if user.food?
    resources << "housing"        if user.shelter?
    resources << "transportation" if user.transport?
    resources << "shower"         if user.shower?
    resources << "laundry"        if user.laundry?
    resources << "buddy system"   if user.buddy?
    resources << "other"          if user.misc?
    resources.join(', ')
  end

end
