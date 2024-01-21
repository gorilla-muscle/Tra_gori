module ApplicationHelper
  def flash_class(type)
    case type
    when 'success' then 'bg-green-500 text-white p-4 rounded-md'
    when 'alert' then 'bg-red-500 text-white p-4 rounded-md'
    when 'info' then 'bg-blue-500 text-white p-4 rounded-md'
    when 'warning' then 'bg-yellow-500 text-white p-4 rounded-md'
    end
  end

  def page_title(title)
    base_title = "トレゴリ"

    title.empty? ? base_title : base_title + " | " + title
  end

  def default_meta_tags
    {
      site: 'トレゴリ',
      title: 'バナナとゴリラで、運動習慣の定着を。',
      reverse: true,
      charset: 'utf-8',
      description: 'トレゴリは、日々の運動内容に応じて『バナナ』と『トレゴリ君からの労いの言葉』をGET出来るサービスです。バナナを使用する事でゴリラのガチャをGETする事が出来るので、ゲーム感覚で運動の記録を行う事が出来ます。',
      keywords: '運動,習慣,スポーツ,ゴリラ,バナナ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用設定
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
