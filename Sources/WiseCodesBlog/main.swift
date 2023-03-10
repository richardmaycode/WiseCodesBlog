import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct WiseCodesBlog: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Richard Wise Codes"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
//try WiseCodesBlog().publish(withTheme: .basic, deployedUsing: .gitHub("richardmaycode/WiseCodesBlog-deploy"))

try WiseCodesBlog().publish(using: [
    .copyResources(),
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .generateHTML(withTheme: .basic),
    .unwrap(RSSFeedConfiguration.default) { config in
            .generateRSSFeed(including: [.posts], config: config)
    },
    .generateSiteMap(),
    .deploy(using: .gitHub("richardmaycode/WiseCodesBlog-deploy"))
])
