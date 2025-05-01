export const fakeUser = (req, res, next) => {
    req.user = { id: '6813a1c255775f49fb880787', name: 'Test User' }; // Example fake user
    next();
};  