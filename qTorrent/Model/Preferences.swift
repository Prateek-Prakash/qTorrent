//
//  Preferences.swift
//  qTorrent
//
//  Created by Prateek Prakash on 5/30/22.
//

import SwiftUI

struct Preferences: Identifiable, Codable {
    var id: UUID = UUID()
    var locale: String?
    var isCreateSubfolderEnabled: Bool?
    var isStartPausedEnabled: Bool
    var autoDeleteMode: Int
    var isPreallocateAll: Bool?
    var isIncompleteFilesExt: Bool?
    var isAutoTMNEnabled: Bool?
    var isTorrentChangedTMNEnabled: Bool?
    var isSavePathChangedTMNEnabled: Bool?
    var isCategoryChangedTMNEnabled: Bool?
    var savePath: String?
    var isTempPathEnabled: Bool?
    var TempPath: String?
//    var scanDirs: ?
    var exportDir: String?
    var exportDirFin: String?
    var isMailMotificationEnabled: Bool?
    var mailNotificationSender: String?
    var mailNotificationEmail: String?
    var mailNotificationSMTP: String?
    var mailNotificationSSLEnabled: Bool?
    var mailNotificationAuthEnabled: Bool?
    var mailMotificationUsername: String?
    var mailNotificationPassword: String?
    var isAutorunEnabled: Bool?
    var autorunProgram: String?
    var isQueueingEnabled: Bool?
    var maxActiveDownloads: Int?
    var maxActiveTorrents: Int?
    var maxActiveUploads: Int?
    var isDoNotCountSlowTorrents: Bool?
    var slowTorrentDLRateThreshold: Int?
    var slowTorrentULRateThreshold: Int?
    var slowTorrentInactiveTimer: Int?
    var isMaxRatioEnabled: Bool?
    var maxRatio: Float?
    var maxRatioAct: Int?
    var listenPort: Int?
    var isUPNP: Bool?
    var isRandomPort: Bool?
    var dlLimit: Int?
    var upLimit: Int?
    var maxConnec: Int?
    var maxConnecPerTorrent: Int?
    var maxUploads: Int?
    var maxUploadsPerTorrent: Int?
    var stopTrackerTimeout: Int?
    var isPieceExtentAffinityEnabled: Bool?
    var bittorrentProtocol: Int?
    var isLimitUTPRate: Bool?
    var isLimitTCPOverhead: Bool?
    var isLimitLANPeers: Bool?
    var altALLimit: Int?
    var altUPLimit: Int?
    var isSchedulerEnabled: Bool?
    var scheduleFromHour: Int?
    var scheduleFromMin: Int?
    var scheduleToHour: Int?
    var scheduleToMin: Int?
    var schedulerDays:Int?
    var isDHT: Bool
    var isPeX: Bool
    var isLSD: Bool
    var encryption: Int?
    var isAnonymousMode: Bool
    var proxyType: Int?
    var proxyIP: String?
    var proxyPort: Int?
    var isProxyPeerConnections: Bool?
    var isProxyAuthEnabled: Bool?
    var proxyUsername: String?
    var proxyPassword: String?
    var isProxyTorrentsOnly: Bool?
    var isIPFilterEnabled: Bool?
    var ipFilterPath: String?
    var isIPFilterTrackers: Bool?
    var webUIDomainList: String?
    var webUIAddress: String?
    var webUIPort: Int?
    var isWebUIUPNP: Bool?
    var webUIUsername: String?
    var webUIPassword: String?
    var isWebUICSRFProtectionEnabled: Bool
    var isWebUIClickjackingProtectionEnabled: Bool
    var isWebUISecureCookieEnabled: Bool?
    var webUIMaxAuthFailCount: Int?
    var webUIBanDuration: Int?
    var webUISessionTimeout: Int?
    var isWebUIHostHeaderValidationEnabled: Bool
    var isBypassLocalAuth: Bool?
    var isBypassAuthSubnetWhitelistEnabled: Bool?
    var bypassAuthSubnetWhitelist: String?
    var isAlternativeWebUIEnabled: Bool?
    var alternativeWebIOPath: String?
    var isUseHTTPS: Bool?
    var sslKey: String?
    var sslCert: String?
    var webUIHTTPSKeyPath: String?
    var webUIHTTPSCertPath: String?
    var isDynDNSEnabled: Bool?
    var dynDNSService: Int?
    var dynDNSUsername: String?
    var dynDNSPassword: String?
    var dynDNSDomain: String?
    var rssRefreshInterval: Int?
    var rssMaxArticlesPerFeed: Int?
    var isRSSProcessingEnabled: Bool
    var isRSSAutoDownloadingEnabled: Bool
    var isRSSDownloadRepackProperEpisodes: Bool
    var rssSmartEpisodeFilters: String?
    var isAddTrackersEnabled: Bool?
    var addTrackers: String?
    var isWebUIUseCustomHTTPHeadersEnabled: Bool?
    var webUICustomHTTPHeaders: String?
    var isMaxSeedingTimeEnabled: Bool?
    var maxSeedingTime: Int?
    var announceIP: String?
    var isAnnounceToAllTiers: Bool?
    var isAnnounceToAllTrackers: Bool?
    var asyncIOThreads: Int?
    var bannedIPs: String?
    var checkingMemoryUse: Int?
    var currentInterfaceAddress: String?
    var currentNetworkInterface: String?
    var diskCache: Int?
    var diskCacheTTL: Int?
    var embeddedTrackerPort: Int?
    var isEnableCoalesceReadWrite: Bool
    var isEnableEmbeddedTracker: Bool
    var isEnableMultiConnectionsFromSameIP: Bool?
    var isEnableOSCache: Bool
    var isEnableUploadSuggestions: Bool?
    var filePoolSize: Int?
    var outgoingPortsMax: Int?
    var outgoingPortsMin: Int?
    var isRecheckCompletedTorrents: Bool
    var isResolvePeerCountries: Bool
    var saveResumeDataInterval: Int?
    var sendBufferLowWatermark: Int?
    var sendBufferWatermark: Int?
    var sendBufferWatermarkFactor: Int?
    var socketBacklogSize: Int?
    var uploadChokingAlgorithm: Int?
    var uploadSlotsBehavior: Int?
    var upnpLeaseDuration: Int?
    var utpTCPMixedMode: Int?
    
    enum CodingKeys: String, CodingKey {
        case locale = "locale"
        case isCreateSubfolderEnabled = "create_subfolder_enabled"
        case isStartPausedEnabled = "start_paused_enabled"
        case autoDeleteMode = "auto_delete_mode"
        case isPreallocateAll = "preallocate_all"
        case isIncompleteFilesExt = "incomplete_files_ext"
        case isAutoTMNEnabled = "auto_tmm_enabled"
        case isTorrentChangedTMNEnabled = "torrent_changed_tmm_enabled"
        case isSavePathChangedTMNEnabled = "save_path_changed_tmm_enabled"
        case isCategoryChangedTMNEnabled = "category_changed_tmm_enabled"
        case savePath = "save_path"
        case isTempPathEnabled = "temp_path_enabled"
        case TempPath = "temp_path"
//        case scanDirs = "scan_dirs"
        case exportDir = "export_dir"
        case exportDirFin = "export_dir_fin"
        case isMailMotificationEnabled = "mail_notification_enabled"
        case mailNotificationSender = "mail_notification_sender"
        case mailNotificationEmail = "mail_notification_email"
        case mailNotificationSMTP = "mail_notification_smtp"
        case mailNotificationSSLEnabled = "mail_notification_ssl_enabled"
        case mailNotificationAuthEnabled = "mail_notification_auth_enabled"
        case mailMotificationUsername = "mail_notification_username"
        case mailNotificationPassword = "mail_notification_password"
        case isAutorunEnabled = "autorun_enabled"
        case autorunProgram = "autorun_program"
        case isQueueingEnabled = "queueing_enabled"
        case maxActiveDownloads = "max_active_downloads"
        case maxActiveTorrents = "max_active_torrents"
        case maxActiveUploads = "max_active_uploads"
        case isDoNotCountSlowTorrents = "dont_count_slow_torrents"
        case slowTorrentDLRateThreshold = "slow_torrent_dl_rate_threshold"
        case slowTorrentULRateThreshold = "slow_torrent_ul_rate_threshold"
        case slowTorrentInactiveTimer = "slow_torrent_inactive_timer"
        case isMaxRatioEnabled = "max_ratio_enabled"
        case maxRatio = "max_ratio"
        case maxRatioAct = "max_ratio_act"
        case listenPort = "listen_port"
        case isUPNP = "upnp"
        case isRandomPort = "random_port"
        case dlLimit = "dl_limit"
        case upLimit = "up_limit"
        case maxConnec = "max_connec"
        case maxConnecPerTorrent = "max_connec_per_torrent"
        case maxUploads = "max_uploads"
        case maxUploadsPerTorrent = "max_uploads_per_torrent"
        case stopTrackerTimeout = "stop_tracker_timeout"
        case isPieceExtentAffinityEnabled = "enable_piece_extent_affinity"
        case bittorrentProtocol = "bittorrent_protocol"
        case isLimitUTPRate = "limit_utp_rate"
        case isLimitTCPOverhead = "limit_tcp_overhead"
        case isLimitLANPeers = "limit_lan_peers"
        case altALLimit = "alt_dl_limit"
        case altUPLimit = "alt_up_limit"
        case isSchedulerEnabled = "scheduler_enabled"
        case scheduleFromHour = "schedule_from_hour"
        case scheduleFromMin = "schedule_from_min"
        case scheduleToHour = "schedule_to_hour"
        case scheduleToMin = "schedule_to_min"
        case schedulerDays = "scheduler_days"
        case isDHT = "dht"
        case isPeX = "pex"
        case isLSD = "lsd"
        case encryption = "encryption"
        case isAnonymousMode = "anonymous_mode"
        case proxyType = "proxy_type"
        case proxyIP = "proxy_ip"
        case proxyPort = "proxy_port"
        case isProxyPeerConnections = "proxy_peer_connections"
        case isProxyAuthEnabled = "proxy_auth_enabled"
        case proxyUsername = "proxy_username"
        case proxyPassword = "proxy_password"
        case isProxyTorrentsOnly = "proxy_torrents_only"
        case isIPFilterEnabled = "ip_filter_enabled"
        case ipFilterPath = "ip_filter_path"
        case isIPFilterTrackers = "ip_filter_trackers"
        case webUIDomainList = "web_ui_domain_list"
        case webUIAddress = "web_ui_address"
        case webUIPort = "web_ui_port"
        case isWebUIUPNP = "web_ui_upnp"
        case webUIUsername = "web_ui_username"
        case webUIPassword = "web_ui_password"
        case isWebUICSRFProtectionEnabled = "web_ui_csrf_protection_enabled"
        case isWebUIClickjackingProtectionEnabled = "web_ui_clickjacking_protection_enabled"
        case isWebUISecureCookieEnabled = "web_ui_secure_cookie_enabled"
        case webUIMaxAuthFailCount = "web_ui_max_auth_fail_count"
        case webUIBanDuration = "web_ui_ban_duration"
        case webUISessionTimeout = "web_ui_session_timeout"
        case isWebUIHostHeaderValidationEnabled = "web_ui_host_header_validation_enabled"
        case isBypassLocalAuth = "bypass_local_auth"
        case isBypassAuthSubnetWhitelistEnabled = "bypass_auth_subnet_whitelist_enabled"
        case bypassAuthSubnetWhitelist = "bypass_auth_subnet_whitelist"
        case isAlternativeWebUIEnabled = "alternative_webui_enabled"
        case alternativeWebIOPath = "alternative_webui_path"
        case isUseHTTPS = "use_https"
        case sslKey = "ssl_key"
        case sslCert = "ssl_cert"
        case webUIHTTPSKeyPath = "web_ui_https_key_path"
        case webUIHTTPSCertPath = "web_ui_https_cert_path"
        case isDynDNSEnabled = "dyndns_enabled"
        case dynDNSService = "dyndns_service"
        case dynDNSUsername = "dyndns_username"
        case dynDNSPassword = "dyndns_password"
        case dynDNSDomain = "dyndns_domain"
        case rssRefreshInterval = "rss_refresh_interval"
        case rssMaxArticlesPerFeed = "rss_max_articles_per_feed"
        case isRSSProcessingEnabled = "rss_processing_enabled"
        case isRSSAutoDownloadingEnabled = "rss_auto_downloading_enabled"
        case isRSSDownloadRepackProperEpisodes = "rss_download_repack_proper_episodes"
        case rssSmartEpisodeFilters = "rss_smart_episode_filters"
        case isAddTrackersEnabled = "add_trackers_enabled"
        case addTrackers = "add_trackers"
        case isWebUIUseCustomHTTPHeadersEnabled = "web_ui_use_custom_http_headers_enabled"
        case webUICustomHTTPHeaders = "web_ui_custom_http_headers"
        case isMaxSeedingTimeEnabled = "max_seeding_time_enabled"
        case maxSeedingTime = "max_seeding_time"
        case announceIP = "announce_ip    string"
        case isAnnounceToAllTiers = "announce_to_all_tiers"
        case isAnnounceToAllTrackers = "announce_to_all_trackers"
        case asyncIOThreads = "async_io_threads"
        case bannedIPs = "banned_IPs"
        case checkingMemoryUse = "checking_memory_use"
        case currentInterfaceAddress = "current_interface_address"
        case currentNetworkInterface = "current_network_interface"
        case diskCache = "disk_cache"
        case diskCacheTTL = "disk_cache_ttl"
        case embeddedTrackerPort = "embedded_tracker_port"
        case isEnableCoalesceReadWrite = "enable_coalesce_read_write"
        case isEnableEmbeddedTracker = "enable_embedded_tracker"
        case isEnableMultiConnectionsFromSameIP = "enable_multi_connections_from_same_ip"
        case isEnableOSCache = "enable_os_cache"
        case isEnableUploadSuggestions = "enable_upload_suggestions"
        case filePoolSize = "file_pool_size"
        case outgoingPortsMax = "outgoing_ports_max"
        case outgoingPortsMin = "outgoing_ports_min"
        case isRecheckCompletedTorrents = "recheck_completed_torrents"
        case isResolvePeerCountries = "resolve_peer_countries"
        case saveResumeDataInterval = "save_resume_data_interval"
        case sendBufferLowWatermark = "send_buffer_low_watermark"
        case sendBufferWatermark = "send_buffer_watermark"
        case sendBufferWatermarkFactor = "send_buffer_watermark_factor"
        case socketBacklogSize = "socket_backlog_size"
        case uploadChokingAlgorithm = "upload_choking_algorithm"
        case uploadSlotsBehavior = "upload_slots_behavior"
        case upnpLeaseDuration = "upnp_lease_duration"
        case utpTCPMixedMode = "utp_tcp_mixed_mode"
    }
}
