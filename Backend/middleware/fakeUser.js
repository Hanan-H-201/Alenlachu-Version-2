// fakeUser middleware used for temporary development/testing purposes
export const fakeUser = (req, res, next) => {
    // Extract user ID from request headers or query string (fallback to a default test user ID)
    const userId = req.headers['x-user-id'] || req.query.userId || '6813a1c255775f49fb880787';
    
    // Attach a mock user object to the request
    req.user = {
        id: userId,               // Simulated user ID
        name: 'Test User'         // Simulated user name
    };
    
    next();
};
