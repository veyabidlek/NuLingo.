// models/Category.ts
import mongoose, { Schema, Document } from "mongoose";

export interface ICategory extends Document {
  category_name: string;
  sentences: Array<[string, string, string, string]>;
  createdAt: Date;
}

const CategorySchema = new Schema({
  category_name: {
    type: String,
    required: true,
  },
  sentences: {
    type: [[String]], // Array of arrays, each containing 4 strings
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.model<ICategory>("Category", CategorySchema);
