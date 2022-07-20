public enum ProtectedResourceAuthorizationStatus {
    /// A status that indicates the user hasn’t yet granted or denied authorization.
    case notDetermined
    
    /// A status that indicates the app isn’t permitted to use media capture devices.
    ///
    /// This status occurs when a user can’t change the authorization status, possibly due to the system imposing restrictions like parental controls.
    case restricted
    
    /// A status that indicates the user has explicitly denied an app permission to capture media.
    case denied
    
    /// A status that indicates the user has explicitly granted an app permission to capture media.
    case authorized
    
    case askingUserPermission
    
    // intial status on app launch
    case undefined
}
