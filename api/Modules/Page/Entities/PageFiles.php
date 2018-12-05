<?php

namespace Modules\Page\Entities;

use Illuminate\Database\Eloquent\Model;
use Venturecraft\Revisionable\RevisionableTrait;

class PageFiles extends Model
{
    use RevisionableTrait;
    protected $fillable = ['id','name','original_name','page_id'];
}