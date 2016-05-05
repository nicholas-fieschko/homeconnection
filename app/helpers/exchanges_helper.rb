module ExchangesHelper

  def other_user(exchange=@exchange)
    User.find(current_user.seeker? ? exchange.provider_id : exchange.seeker_id)
  end

  def has_left_review?(user, exchange)
    Review.where(author_id: user.id, exchange_id: exchange.id).any?
  end

  def user_considering_offer?
    # The other user has accepted, but not the current one:
    (current_user.provider? ? @exchange.s_accepted : @exchange.p_accepted) && 
      !(@exchange.s_accepted && @exchange.p_accepted) && (!@exchange.p_finished && !@exchange.s_finished)
  end

  def user_waiting_for_other_to_accept?
    (current_user.provider? ? @exchange.p_accepted : @exchange.s_accepted) &&
      !(@exchange.s_accepted && @exchange.p_accepted)
  end

  def user_waiting_for_other_to_confirm_exchange_occurred?
    (current_user.provider? ? @exchange.p_finished : @exchange.s_finished) &&
      !(@exchange.p_finished && @exchange.s_finished)
  end

  def action_available_to_current_user?
    !@exchange.complete? && (@exchange.new_record? || user_considering_offer? || user_confirming_exchange_occurred?)
  end

  def user_confirming_exchange_occurred?
    # Both users have accepted the exchange, next step is for mutual confirmation the exchange was completed
    (@exchange.s_accepted && @exchange.p_accepted) && (current_user.seeker? ? !@exchange.s_finished : !@exchange.p_finished)
  end

  def action_text
    if @exchange.new_record?
      current_user.provider? ? "Offer help" : "Request help"
    elsif user_considering_offer?
      "Accept #{current_user.provider? ? 'request' : 'offer'}"
    else
      "Confirm exchange completed"
    end
  end

  def user_next_step
    if @exchange.new_record? or user_considering_offer?
      new_field = current_user.seeker? ? :s_accepted : :p_accepted
    elsif user_confirming_exchange_occurred?
      new_field = current_user.seeker? ? :s_finished : :p_finished
    end
  end

  def ids_of_exchange
    ids = {}
    if @exchange.new_record?
      ids[:provider] = current_user.provider? ? current_user.id         : params[:target_user_id]
      ids[:seeker]   = current_user.provider? ? params[:target_user_id] : current_user.id
    else
      ids[:provider] = @exchange.provider_id
      ids[:seeker]   = @exchange.seeker_id
    end
    ids
  end

end
