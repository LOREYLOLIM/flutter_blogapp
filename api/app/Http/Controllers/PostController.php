<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Http\Resources\CommentResource;
use App\Models\Category;
use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    //
    public function index(){
        $posts = Post::with('categories')->latest()->get();
        return response([
            'message'=>'success',
            'post' => $posts,
        ], 200);
    }
    public function store(PostRequest $postRequest){
        // return response([
        //     'admin'=>auth()->guard('admins')->user()->email,
        // ], 200);

        $postRequest->validated();

        $image = $postRequest->file('image');
        $imageName = uniqid().$image->getClientOriginalName();
        $image->move(public_path('postImages'), $imageName);

        $res = auth()->guard('admins')->user()->posts()->create([
            'title' => $postRequest->title,
            'body' => $postRequest->body,
            'image' => $imageName,
        ]);

        if($res){
            foreach($postRequest->category as $cat){
                $cat = Category::create([
                    'post_id' => $res->id,
                    'cat_name'=>$cat,
                ]);
            }
        }else{
            return response([
                'message'=>'Error making post',
            ], 500);
        }

        if($cat){
            return response([
                'message'=>'Success',
            ], 500);
        }else{
            return response([
                'message'=>'Error making post',
            ], 500);
        }
    }

    public function comment(Request $request, $post_id){
        $request->validate([
            'name'=>'required',
            'email'=>'required|email',
            'comment'=>'required',
        ]);

        $com = Comment::create([
            'post_id'=>$post_id,
            'name' => $request->name,
            'email'=>$request->email,
            'comment'=>$request->comment,
        ]);

        if($com){
            return response([
                'message'=>'success',
            ], 201);
        }else{
            return response([
                'message'=>'error',
            ], 400);
        }
    }

    public function getComments($post_id){
        $comments = Comment::with('post')->wherePostId($post_id)->latest()->get();

        return response([
            // 'comment'=>$comments
            'comment'=> CommentResource::collection($comments)

        ], 200);
    }
}
