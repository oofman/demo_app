class Champion < ApplicationRecord
  has_and_belongs_to_many :tags




  def self._get_list_page(params)

    _where = ' '
    _page = (params[:page].present?) ? params[:page] : 1

    if params[:search].present? && params[:search] != ''
      if !params[:search].blank?
        search_params = params[:search].gsub /'/, ''
        _where += " champions.name ILIKE '%#{search_params}%' "
      end
    end


    _items = Champion
                 .where(_where)
                 .order('champions.name ASC')
                 .paginate(:page => _page, :per_page => 10)

    return _items
  end

  def self._get_list_page_stats(params)
    _where = ' '
    _page = (params[:page].present?) ? params[:page] : 1

    if params[:search].present? && params[:search] != ''
      if !params[:search].blank?
        search_params = params[:search].gsub /'/, ''
        _where += " champions.name ILIKE '%#{search_params}%' "
      end
    end

    _count = Champion.where(_where).count
    _offset = (10 * _page.to_i) - 10

    return { info: {
        :amount => _count,
        :page => _page,
        :total_pages => (_count/10.to_f).ceil,
        :per_page => 10,
        :str => "Viewing #{_offset+1} to #{_offset+10} out of #{_count} champions",
    }}

  end

end
