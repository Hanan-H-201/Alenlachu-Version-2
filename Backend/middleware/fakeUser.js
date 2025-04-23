export const fakeUser = (req, res, next) => {
    req.user = { id: '661e123abc456def78901234', name: 'Test User' }; // Example fake user
    next();
};  