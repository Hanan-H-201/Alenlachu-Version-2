export const fakeUser = (req, res, next) => {
    const userId = req.headers['x-user-id'] || req.query.userId || '6813a1c255775f49fb880787';
    
    req.user = {
        id: userId,
        name: 'Test User'
    };
    
    next();
};
