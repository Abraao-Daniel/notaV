const express = require("express")
const router = express.Router()
const { User } = require("../models")


router.get("/", async (req, res) => {
    const Lista = await User.findAll()
    res.json(Lista)
});


router.post("/", async (req, res) => {
    const user = req.body
    await User.create(user)
    res.json(user)
})

module.exports = router