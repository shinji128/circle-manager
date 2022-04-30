module ApplicationHelper
  def default_meta_tags
    {
      site: 'CircleManager',
      title: 'CircleManager',
      reverse: true,
      charset: 'utf-8',
      separator: ' - ',
      description: 'サークルを作ってシャッフル機能で試合の組み合わせを自動生成できるアプリ',
      keywords: 'シャッフル,バドミントン,テニス,組み合わせ,対戦表',
      canonical: request.original_url,
      icon: [
        { href: image_url('favicon.png') },
        { href: image_url('favicon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        url: request.original_url,
        image: image_url('ogp.png'),
        type: 'website',
        locale: 'ja_JP'
      },
      twitter: {
        site: '@Shinji20253832',
        card: 'summary_large_image'
      }
    }
  end
end
