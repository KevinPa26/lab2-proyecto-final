'use strict';
const {
    Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Role extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            Role.hasMany(models.Usuario);
        }
    };
    Role.init({
        nombre:{type: DataTypes.STRING, allowNull:false},
        informacion:{type: DataTypes.STRING, allowNull:false},
        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'Role',
    timestamps: true,
  });
  return Role;
};