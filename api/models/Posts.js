const { Sequelize, DataTypes } = require("sequelize");

module.exports = (Sequelize, DataTypes) => {
    const User = Sequelize.define("User", {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            alloNull: false,
        },
        User: {
            type: DataTypes.STRING,
            alloNull: false,
        }, 
		  {
        timestamps: false
			}
    })
    return User
}