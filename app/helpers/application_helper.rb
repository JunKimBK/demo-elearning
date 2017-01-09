module ApplicationHelper
  def user_name activity
    if activity.user.id == current_user.id
      t "activity_user_name_you"
    else
      activity.user_name
    end
  end

  def action_message activity
    case activity.action_type
    when Activity.activity_types[:follow]
      t "type_1"
    when Activity.activity_types[:unfollow]
      t "type_2"
    else
      t "type_0"
    end
  end

  def target_link activity
    category = Category.find_by id: activity.type_id
    if activity.action_type == Activity.activity_types[:start_lesson]
      @lesson = Lesson.find_by id: activity.type_id
      link_to @lesson.category.name, category_lesson_path(category, @lesson)
    else
      @user = User.find_by id: activity.type_id
      link_to @user.name, @user
    end
  end
end
