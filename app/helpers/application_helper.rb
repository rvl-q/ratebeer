module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    # del = link_to('Destroy', item, method: :delete, # this may work... ?
    #                                form: { data: { turbo_confirm: "Are you sure ?" } },
    # del = button_to('Destroy', item, method: :delete, # workaround
    #                                  form: { data: { turbo_confirm: "Are you sure ?" } },
    #                                  class: "btn btn-danger")
    del = link_to('Destroy', item, method: :delete,
                                   form: { data: { turbo_confirm: "Are you sure ?" } },
                                   class: "btn btn-danger")
    raw("#{edit} #{del}")
    if current_user.admin?
      raw("#{edit} #{del}")
    else
      raw(edit)
    end
  end

  def round_one_decimal(num)
    number_with_precision(num, precision: 1).to_s
  end

  def round(num, prec: 1)
    number_with_precision(num, precision: prec).to_s
  end
end
