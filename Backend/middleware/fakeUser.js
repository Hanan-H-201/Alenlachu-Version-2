export const fakeUser = (req, res, next) => {
    const userId = req.headers['x-user-id'] || req.query.userId || 'user_id';
    
    req.user = {
        id: userId,
        name: 'Test User'
    };
    
    next();
};
