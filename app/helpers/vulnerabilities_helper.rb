module VulnerabilitiesHelper
  
  def link_to_google(vulnerability)
    link_to '', url_to_google(vulnerability), class: 'vuln_link google_link', target: '_blank'
  end

  def link_to_nvd(vulnerability)
    link_to '', url_to_nvd(vulnerability), class: 'vuln_link nvd_link', target: '_blank'
  end

  def link_to_cve_details(vulnerability)
    link_to '', url_to_cve_details(vulnerability), class: 'vuln_link cve_details_link', target: '_blank'
  end

  def url_to_nvd(vulnerability)
    "https://nvd.nist.gov/vuln/detail/#{vulnerability.name}"
  end

  def url_to_cve_details(vulnerability)
    "http://www.cvedetails.com/cve/#{vulnerability.name}/"
  end

  def url_to_google(vulnerability)
    "https://www.google.com/search?q=#{vulnerability.name}"
  end
  
  def link_to_vulnerability(vulnerability)
    link_to vulnerability.name, vulnerability, title: vulnerability.summary
  end

  def ago_helper(modified)
   if modified.nil?
    return "?"
   end
   return (time_ago_in_words(modified.to_datetime).sub(' ', '&nbsp') + '&nbspago').to_s.html_safe 
  end

  def flip_sorting_way()
    par = @search_params[:sorting_way]
    if par.nil? or par == 'asc'
      return 'desc'
    else
      return 'asc'
    end
  end

  def class_for_sorting_link(sorting_param)
    par = @search_params[:sorting]
    if par.nil? or par.blank? or  par != sorting_param 
      return 'sorting-link unsorted'
    end
    if par == sorting_param
      case flip_sorting_way
        when 'asc'
          return 'sorting-link descending'
        else
          return 'sorting-link ascending'
      end
    end
  end

  def sorting_link_to(title, sorting_param, other = {})
    other = {} if other.nil? or other.class != Hash
    other[:class] = class_for_sorting_link(sorting_param)
    return link_to title, request.query_parameters.merge({:sorting => sorting_param, :sorting_way => flip_sorting_way }), other
  end

  def projects_filter_collection()
    [['at least one', 0]].concat( current_user.projects.map(&->(p){[p.name, p.id]}) )
  end

end
