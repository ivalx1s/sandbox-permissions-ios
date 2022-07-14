import os.log
import Foundation

let moduleSubsystem = Bundle.module.description

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11, *)
internal let performanceOSLog = OSLog(subsystem: moduleSubsystem, category: "🎭 Performance")

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11, *)
internal extension os.Logger {
    

    /// A logger instance that logs to '🔤Default' category within host app subsystem.
    static let `default` = os.Logger(subsystem: moduleSubsystem, category: "🔤Default")
    /// A logger instance that logs to '♦️Debug' category within host app subsystem.
    static let debug = os.Logger(subsystem: moduleSubsystem, category: "♦️Debug")
    
    static let performance = os.Logger.init(subsystem: moduleSubsystem, category: "🎭 Performance")
    
    static let module = os.Logger(subsystem: moduleSubsystem, category: "💼SandboxPermissions")
}


/// A proxy type to work around apple os log [limitations](https://stackoverflow.com/questions/62675874/xcode-12-and-oslog-os-log-wrapping-oslogmessage-causes-compile-error-argumen#63036815).
///
///
internal enum _OSLogPrivacy: Equatable {
    case  auto, `public`, `private`, sensitive
}


@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11, *)
internal func log(
    _ message: String,
    logType: OSLogType = .default,
    category: os.Logger = .module,
    privacy: _OSLogPrivacy = .private,
    includeCallerLocation: Bool = false,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) {
    
    var message = message
    if includeCallerLocation {
        let moduleAndFileName = fileID.replacingOccurrences(of: ".swift", with: "")
        let moduleName = String("\(fileID)".prefix(while: { $0 != "/" }))
        let fileName = moduleAndFileName
            .split(separator: "/")
            .suffix(1)
            .description
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "]", with: "")
        let logLocationDescription = "\(lineNumber):\(moduleName).\(fileName).\(functionName)"
        message = "\(message) \n> location: \(logLocationDescription)"
    }
    
    // privacy argument must be resolved on compile time, hence ugly workaround
    // more info:
    // https://stackoverflow.com/questions/62675874/xcode-12-and-oslog-os-log-wrapping-oslogmessage-causes-compile-error-argumen#63036815
    switch privacy {
    case .private:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .private)")
    case .public:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .public)")
    case .auto:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .auto)")
    case .sensitive:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .sensitive)")
    }
}

/// Logs a debug message to console; Works only in DEBUG build configuration.
public func debug(
    _ message: String,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) {
    #if DEBUG
    log(
        message,
        logType: .debug,
        category: .debug,
        includeCallerLocation: true,
        fileID: fileID,
        functionName: functionName,
        lineNumber: lineNumber
    )
    #endif
}
