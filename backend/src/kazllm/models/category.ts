// models/Category.ts
import mongoose, { Schema, Document } from "mongoose";

export interface ICategory extends Document {
  userId: mongoose.Types.ObjectId;
  category_name: string;
  sentences: Array<[string, string, string, string]>;
  createdAt: Date;
}

const CategorySchema = new Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  category_name: {
    type: String,
    required: true,
  },
  sentences: [[String]], // Array of arrays, each containing 4 strings
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.model<ICategory>("Category", CategorySchema);
